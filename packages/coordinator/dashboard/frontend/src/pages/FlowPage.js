import React, { useEffect, useMemo, useState, useCallback } from 'react';
import {
  ReactFlow,
  ReactFlowProvider,
  Background,
  Controls,
  MiniMap,
  Handle,
  MarkerType,
  useNodesState,
  useEdgesState,
  useReactFlow,
} from '@xyflow/react';
import '@xyflow/react/dist/style.css';
import { Workflow, AlertCircle, Loader2 } from 'lucide-react';
import { buildCoordinatorApiUrl } from '../coordinators';
import {
  ENGINES,
  ALGORITHMS,
  DIRECTIONS,
  DIR_HANDLES,
  computeLayout,
} from './flowLayout';

// Rhombus node geometry — deliberately wider than tall, and large.
const NODE_W = 200;
const NODE_H = 110;

const KIND_STYLES = {
  initial: { fill: '#dcfce7', stroke: '#22c55e', text: '#166534' },
  terminal: { fill: '#fee2e2', stroke: '#ef4444', text: '#991b1b' },
  normal: { fill: '#eef2ff', stroke: '#6366f1', text: '#3730a3' },
};

// A real CSS rhombus (clip-path diamond) — full control over shape/size/aspect.
const RhombusNode = ({ data }) => {
  const style = KIND_STYLES[data.kind] || KIND_STYLES.normal;
  const handles = DIR_HANDLES[data.dir] || DIR_HANDLES.DOWN;
  return (
    <div style={{ width: NODE_W, height: NODE_H, position: 'relative' }}>
      <Handle type="target" position={handles.target} style={{ opacity: 0 }} />
      <div
        style={{
          width: '100%',
          height: '100%',
          clipPath: 'polygon(50% 0%, 100% 50%, 50% 100%, 0% 50%)',
          background: style.fill,
          border: `2px solid ${style.stroke}`,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <span
          style={{
            color: style.text,
            fontSize: 14,
            fontWeight: 600,
            textAlign: 'center',
            padding: '0 18px',
            wordBreak: 'break-word',
            lineHeight: 1.15,
          }}
        >
          {data.label}
        </span>
      </div>
      <Handle type="source" position={handles.source} style={{ opacity: 0 }} />
    </div>
  );
};

const nodeTypes = { rhombus: RhombusNode };

const transitionLabel = (t) => {
  if (t.trigger === 'timeout') {
    return t.durationSeconds != null ? `timeout ${t.durationSeconds}s` : 'timeout';
  }
  return t.event || t.trigger || '';
};

// Build the (unpositioned) React Flow nodes/edges + layout metadata from a flow.
const buildBase = (flow) => {
  const rfNodes = [];

  flow.states.forEach((state) => {
    rfNodes.push({
      id: state.name,
      type: 'rhombus',
      data: {
        label: state.name,
        kind: state.initial ? 'initial' : state.terminal ? 'terminal' : 'normal',
      },
      position: { x: 0, y: 0 },
    });
  });

  const rfEdges = [];

  // Merge parallel transitions (same source→target) into one labelled edge.
  const merged = new Map();
  flow.states.forEach((state) => {
    state.transitions.forEach((t) => {
      if (!t.target) return;
      const key = `${state.name}->${t.target}`;
      const label = transitionLabel(t);
      if (merged.has(key)) {
        const existing = merged.get(key);
        if (label && !existing.labels.includes(label)) existing.labels.push(label);
      } else {
        merged.set(key, { source: state.name, target: t.target, labels: label ? [label] : [] });
      }
    });
  });
  merged.forEach((e, key) => {
    rfEdges.push({
      id: `e-${key}`,
      source: e.source,
      target: e.target,
      type: 'smoothstep',
      label: e.labels.join(' / '),
      labelStyle: { fontSize: 12, fontWeight: 600, fill: '#475569' },
      labelBgStyle: { fill: '#ffffff', fillOpacity: 0.85 },
      labelBgPadding: [4, 2],
      style: { stroke: '#94a3b8', strokeWidth: 1.5 },
      markerEnd: { type: MarkerType.ArrowClosed, color: '#94a3b8' },
    });
  });

  const layoutNodes = rfNodes.map((n) => ({ id: n.id, width: NODE_W, height: NODE_H }));

  return { rfNodes, rfEdges, layoutNodes };
};

const FlowCanvas = ({ flow, engine, algorithm, direction }) => {
  const base = useMemo(() => buildBase(flow), [flow]);
  const [nodes, setNodes, onNodesChange] = useNodesState([]);
  const [edges, setEdges, onEdgesChange] = useEdgesState([]);
  const [laying, setLaying] = useState(true);
  const { fitView } = useReactFlow();

  useEffect(() => {
    let cancelled = false;
    setLaying(true);
    computeLayout(base.layoutNodes, base.rfEdges, { engine, algorithm, direction })
      .then((pos) => {
        if (cancelled) return;
        const positioned = base.rfNodes.map((n) => ({
          ...n,
          position: pos[n.id] || { x: 0, y: 0 },
          data: { ...n.data, dir: direction },
        }));
        setNodes(positioned);
        setEdges(base.rfEdges);
        setLaying(false);
        // fitView after the new positions are committed.
        window.requestAnimationFrame(() => fitView({ padding: 0.2, duration: 300 }));
      })
      .catch(() => {
        if (!cancelled) setLaying(false);
      });
    return () => {
      cancelled = true;
    };
  }, [base, engine, algorithm, direction, setNodes, setEdges, fitView]);

  return (
    <div style={{ height: '70vh' }} className="relative rounded-xl border border-gray-200 bg-slate-50">
      {laying && (
        <div className="absolute right-3 top-3 z-10 flex items-center gap-1.5 rounded-full bg-white/90 px-3 py-1 text-xs text-slate-500 shadow">
          <Loader2 size={12} className="animate-spin" />
          Laying out…
        </div>
      )}
      <ReactFlow
        nodes={nodes}
        edges={edges}
        onNodesChange={onNodesChange}
        onEdgesChange={onEdgesChange}
        nodeTypes={nodeTypes}
        fitView
        proOptions={{ hideAttribution: true }}
        minZoom={0.1}
      >
        <Background gap={20} color="#e2e8f0" />
        <Controls />
        <MiniMap pannable zoomable nodeColor={(n) => (KIND_STYLES[n.data?.kind] || KIND_STYLES.normal).stroke} />
      </ReactFlow>
    </div>
  );
};

const Select = ({ label, value, onChange, options }) => (
  <label className="flex items-center gap-1.5 text-xs font-medium text-slate-600">
    {label}
    <select
      value={value}
      onChange={(e) => onChange(e.target.value)}
      className="rounded-md border border-gray-300 bg-white px-2 py-1 text-xs text-slate-700 focus:border-indigo-400 focus:outline-none"
    >
      {options.map((o) => (
        <option key={o.id} value={o.id}>
          {o.label}
        </option>
      ))}
    </select>
  </label>
);

const FlowDiagram = ({ flow }) => {
  // Defaults tuned for clarity on dense state machines: ELK layered, vertical.
  const [engine, setEngine] = useState('elk');
  const [algorithm, setAlgorithm] = useState('layered');
  const [direction, setDirection] = useState('DOWN');

  // Keep the algorithm valid when the engine changes.
  const onEngineChange = useCallback((next) => {
    setEngine(next);
    setAlgorithm(ALGORITHMS[next][0].id);
  }, []);

  return (
    <div>
      <div className="mb-3 flex flex-wrap items-center gap-4 rounded-xl border border-gray-200 bg-white px-4 py-2.5">
        <Select label="Engine" value={engine} onChange={onEngineChange} options={ENGINES} />
        <Select label="Algorithm" value={algorithm} onChange={setAlgorithm} options={ALGORITHMS[engine]} />
        <Select label="Direction" value={direction} onChange={setDirection} options={DIRECTIONS} />
      </div>

      <ReactFlowProvider>
        <FlowCanvas flow={flow} engine={engine} algorithm={algorithm} direction={direction} />
      </ReactFlowProvider>
    </div>
  );
};

const FlowPage = ({ selectedCoordinatorId, coordinators = [] }) => {
  const coordinator = coordinators.find((c) => c.id === selectedCoordinatorId) || null;
  const coordinatorFlowId = coordinator?.flowId || null;

  const [flows, setFlows] = useState([]);
  const [selectedFlowId, setSelectedFlowId] = useState(coordinatorFlowId || '');
  const [flow, setFlow] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    let cancelled = false;
    fetch(buildCoordinatorApiUrl('/api/flows'))
      .then((res) => res.json())
      .then((data) => {
        if (cancelled) return;
        const list = data.flows || [];
        setFlows(list);
        setSelectedFlowId((current) => {
          if (current && list.some((f) => f.id === current)) return current;
          if (coordinatorFlowId && list.some((f) => f.id === coordinatorFlowId)) {
            return coordinatorFlowId;
          }
          return list[0]?.id || '';
        });
      })
      .catch((err) => {
        if (!cancelled) setError(err.message || String(err));
      });
    return () => {
      cancelled = true;
    };
  }, [coordinatorFlowId]);

  useEffect(() => {
    if (!selectedFlowId) {
      setFlow(null);
      setLoading(false);
      return undefined;
    }
    let cancelled = false;
    setLoading(true);
    setError(null);
    fetch(buildCoordinatorApiUrl(`/api/flows/${selectedFlowId}`))
      .then(async (res) => {
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        return res.json();
      })
      .then((data) => {
        if (cancelled) return;
        setFlow(data);
        setLoading(false);
      })
      .catch((err) => {
        if (cancelled) return;
        setError(err.message || String(err));
        setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, [selectedFlowId]);

  return (
    <div className="mx-auto max-w-6xl px-4 py-6">
      <div className="mb-5 flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-2">
          <Workflow size={20} className="text-indigo-600" />
          <h1 className="text-xl font-semibold text-slate-800">Flow state diagram</h1>
        </div>

        {flows.length > 0 && (
          <div className="flex items-center gap-1 rounded-full border border-gray-200 bg-white px-1.5 py-1">
            {flows.map((f) => (
              <button
                key={f.id}
                type="button"
                onClick={() => setSelectedFlowId(f.id)}
                className={`rounded-full px-3 py-1 text-sm font-medium transition-all ${
                  selectedFlowId === f.id
                    ? 'bg-gradient-to-r from-blue-600 to-indigo-600 text-white shadow-sm'
                    : 'text-gray-600 hover:bg-gray-100'
                }`}
              >
                {f.label}
              </button>
            ))}
          </div>
        )}
      </div>

      {coordinator && coordinatorFlowId && selectedFlowId === coordinatorFlowId && (
        <p className="mb-3 text-sm text-slate-500">
          Showing the flow configured for <span className="font-medium">{coordinator.label}</span>.
        </p>
      )}

      {loading && (
        <div className="flex items-center gap-2 py-10 text-slate-500">
          <Loader2 size={18} className="animate-spin" />
          Loading flow…
        </div>
      )}

      {!loading && error && (
        <div className="flex items-center gap-2 rounded-lg border border-red-200 bg-red-50 px-4 py-3 text-sm text-red-700">
          <AlertCircle size={16} />
          {error}
        </div>
      )}

      {!loading && !error && !selectedFlowId && (
        <div className="py-10 text-center text-sm text-slate-500">
          No flow definitions are available on this server.
        </div>
      )}

      {!loading && !error && flow && <FlowDiagram flow={flow} />}

      {!loading && !error && flow && (
        <div className="mt-4 flex flex-wrap items-center gap-4 text-xs text-slate-500">
          <span className="inline-flex items-center gap-1.5">
            <span className="inline-block h-3 w-3 rotate-45 border border-green-500 bg-green-100" />
            Initial
          </span>
          <span className="inline-flex items-center gap-1.5">
            <span className="inline-block h-3 w-3 rotate-45 border border-indigo-500 bg-indigo-100" />
            State
          </span>
          <span className="inline-flex items-center gap-1.5">
            <span className="inline-block h-3 w-3 rotate-45 border border-red-500 bg-red-100" />
            Terminal
          </span>
          <span>{flow.states.length} states</span>
          <span>{flow.states.reduce((n, s) => n + s.transitions.length, 0)} transitions</span>
        </div>
      )}
    </div>
  );
};

export default FlowPage;

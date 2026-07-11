import dagre from '@dagrejs/dagre';
import ELK from 'elkjs/lib/elk.bundled.js';
import { Position } from '@xyflow/react';

// Layout engines and the algorithms each exposes. React Flow has no built-in
// layout, so these come straight from the layout libs (dagre + ELK).
export const ENGINES = [
  { id: 'dagre', label: 'Dagre' },
  { id: 'elk', label: 'ELK' },
];

export const ALGORITHMS = {
  // dagre's "ranker" — how node ranks are assigned.
  dagre: [
    { id: 'network-simplex', label: 'Network simplex' },
    { id: 'tight-tree', label: 'Tight tree' },
    { id: 'longest-path', label: 'Longest path' },
  ],
  // ELK's top-level algorithm.
  elk: [
    { id: 'layered', label: 'Layered' },
    { id: 'mrtree', label: 'Tree' },
    { id: 'force', label: 'Force' },
    { id: 'radial', label: 'Radial' },
    { id: 'stress', label: 'Stress' },
  ],
};

export const DIRECTIONS = [
  { id: 'DOWN', label: 'Vertical ↓' },
  { id: 'RIGHT', label: 'Horizontal →' },
  { id: 'UP', label: 'Vertical ↑' },
  { id: 'LEFT', label: 'Horizontal ←' },
];

// Per-direction handle/edge attach positions so edges leave/enter the right side.
export const DIR_HANDLES = {
  DOWN: { target: Position.Top, source: Position.Bottom },
  UP: { target: Position.Bottom, source: Position.Top },
  RIGHT: { target: Position.Left, source: Position.Right },
  LEFT: { target: Position.Right, source: Position.Left },
};

const DAGRE_RANKDIR = { DOWN: 'TB', UP: 'BT', RIGHT: 'LR', LEFT: 'RL' };

const elk = new ELK();

const layoutDagre = (nodes, edges, { algorithm, direction }) => {
  const g = new dagre.graphlib.Graph();
  g.setDefaultEdgeLabel(() => ({}));
  g.setGraph({
    rankdir: DAGRE_RANKDIR[direction] || 'TB',
    ranker: algorithm || 'network-simplex',
    nodesep: 60,
    ranksep: 90,
    marginx: 20,
    marginy: 20,
  });
  nodes.forEach((n) => g.setNode(n.id, { width: n.width, height: n.height }));
  edges.forEach((e) => g.setEdge(e.source, e.target));
  dagre.layout(g);
  const pos = {};
  nodes.forEach((n) => {
    const { x, y } = g.node(n.id);
    pos[n.id] = { x: x - n.width / 2, y: y - n.height / 2 };
  });
  return Promise.resolve(pos);
};

const layoutElk = async (nodes, edges, { algorithm, direction }) => {
  const algo = algorithm || 'layered';
  const graph = {
    id: 'root',
    layoutOptions: {
      'elk.algorithm': algo,
      'elk.direction': direction || 'DOWN',
      // Orthogonal routing + generous spacing keeps ranks, edges and labels from
      // piling on top of each other in a dense state machine.
      'elk.edgeRouting': 'ORTHOGONAL',
      'elk.spacing.nodeNode': '70',
      'elk.spacing.edgeNode': '35',
      'elk.spacing.edgeEdge': '25',
      'elk.spacing.edgeLabel': '8',
      'elk.layered.spacing.nodeNodeBetweenLayers': '110',
      'elk.layered.spacing.edgeNodeBetweenLayers': '40',
      'elk.layered.nodePlacement.strategy': 'NETWORK_SIMPLEX',
      'elk.layered.considerModelOrder.strategy': 'NODES_AND_EDGES',
      'elk.layered.crossingMinimization.strategy': 'LAYER_SWEEP',
      // Pull self/back-edges to one side so they don't cross the trunk.
      'elk.layered.feedbackEdges': 'true',
    },
    children: nodes.map((n) => ({ id: n.id, width: n.width, height: n.height })),
    // Pass label dimensions so ELK reserves room for edge labels.
    edges: edges.map((e) => {
      const label = e.label || '';
      const out = { id: e.id, sources: [e.source], targets: [e.target] };
      if (label) {
        out.labels = [{ text: label, width: Math.max(24, label.length * 6.5), height: 16 }];
      }
      return out;
    }),
  };
  const res = await elk.layout(graph);
  const pos = {};
  (res.children || []).forEach((c) => {
    pos[c.id] = { x: c.x, y: c.y };
  });
  return pos;
};

// Compute a position map { nodeId: {x, y} } for the chosen engine/options.
// `nodes` items carry { id, width, height }; `edges` carry { id, source, target }.
export const computeLayout = (nodes, edges, opts) =>
  (opts.engine === 'elk' ? layoutElk : layoutDagre)(nodes, edges, opts);

package app.bitblik;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.robolectric.Shadows.shadowOf;

import android.app.Service;
import android.content.Intent;
import android.content.pm.ServiceInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.robolectric.Robolectric;
import org.robolectric.RobolectricTestRunner;
import org.robolectric.annotation.Config;

@RunWith(RobolectricTestRunner.class)
@Config(sdk = 35)
public class OfferMonitoringServiceTest {
  @Test
  public void stickyRestartWithoutIntentStopsWithoutCrashing() {
    OfferMonitoringService service = Robolectric.buildService(OfferMonitoringService.class).create().get();
    assertEquals(Service.START_NOT_STICKY, service.onStartCommand(null, 0, 1));
    assertTrue(shadowOf(service).isStoppedBySelf());
  }

  @Test
  public void missingParametersStopWithoutCrashing() {
    OfferMonitoringService service = Robolectric.buildService(OfferMonitoringService.class).create().get();
    assertEquals(Service.START_NOT_STICKY, service.onStartCommand(new Intent(), 0, 1));
    assertTrue(shadowOf(service).isStoppedBySelf());
  }

  @Test
  public void validStartShowsPersistentNotificationWithoutStickyRestart() {
    OfferMonitoringService service = Robolectric.buildService(OfferMonitoringService.class).create().get();
    Intent intent = new Intent().putExtra("title", "Offers").putExtra("body", "Monitoring");
    assertEquals(Service.START_NOT_STICKY, service.onStartCommand(intent, 0, 1));
    assertEquals(99, shadowOf(service).getLastForegroundNotificationId());
    assertEquals("Monitoring", shadowOf(service).getLastForegroundNotification().extras.getString("android.text"));
    assertTrue(shadowOf(service).getLastForegroundNotification().contentIntent != null);
  }

  @Test
  public void dataSyncTimeoutStopsService() {
    OfferMonitoringService service = Robolectric.buildService(OfferMonitoringService.class).create().get();
    service.onTimeout(1, ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC);
    assertTrue(shadowOf(service).isStoppedBySelf());
  }
}

package com.example.leocher_app;

import android.annotation.SuppressLint;
import android.os.Build;
import android.os.Bundle;
import android.view.View;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private int currentApiVersion;
    @SuppressLint("NewApi")
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

          currentApiVersion = android.os.Build.VERSION.SDK_INT;

          final int flags = View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                  | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                  | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                  | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY;

          // This work only for android 4.4+
          if(currentApiVersion >= Build.VERSION_CODES.KITKAT)
          {

              getWindow().getDecorView().setSystemUiVisibility(flags);

              // Code below is to handle presses of Volume up or Volume down.
              // Without this, after pressing volume buttons, the navigation bar will
              // show up and won't hide
              final View decorView = getWindow().getDecorView();
              decorView
                      .setOnSystemUiVisibilityChangeListener(new View.OnSystemUiVisibilityChangeListener()
                      {

                          @Override
                          public void onSystemUiVisibilityChange(int visibility)
                          {
                              if((visibility & View.SYSTEM_UI_FLAG_FULLSCREEN) == 0)
                              {
                                  decorView.setSystemUiVisibility(flags);
                              }
                          }
                      });
          }
      }


    @SuppressLint("NewApi")
    @Override
    public void onWindowFocusChanged(boolean hasFocus)
    {
        super.onWindowFocusChanged(hasFocus);
        if(currentApiVersion >= Build.VERSION_CODES.KITKAT && hasFocus)
        {
            getWindow().getDecorView().setSystemUiVisibility(
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                            | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
        }
    }

    @Override
    public void onBackPressed() {}

    public void onRecentPressed() {}
}

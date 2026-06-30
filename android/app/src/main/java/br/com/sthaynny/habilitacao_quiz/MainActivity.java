package br.com.sthaynny.habilitacao_quiz;

import android.os.Bundle;
import androidx.activity.EdgeToEdge;
import io.flutter.embedding.android.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        EdgeToEdge.enable(this);
        super.onCreate(savedInstanceState);
    }
}

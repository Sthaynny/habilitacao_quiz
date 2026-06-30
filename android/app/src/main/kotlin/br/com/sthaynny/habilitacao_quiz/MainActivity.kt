package br.com.sthaynny.habilitacao_quiz

import android.os.Bundle
import androidx.activity.EdgeToEdge
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        EdgeToEdge.enable(this)
        super.onCreate(savedInstanceState)
    }
}

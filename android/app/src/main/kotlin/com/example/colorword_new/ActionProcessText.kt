package com.example.colorword_new
import android.app.Activity
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import android.widget.Toast
import androidx.annotation.RequiresApi
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import kotlin.Exception
import android.content.Intent
import kotlin.random.Random



class ActionProcessText : Activity() {

    private lateinit var auth: FirebaseAuth
    private lateinit var db: FirebaseFirestore

    val rnd = randomHexColor()

    @RequiresApi(Build.VERSION_CODES.M)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Uygulama şeffaf olduğunda arkaplandaki ekranlara dokunma işlemlerinin yapılabilmesi için kullandık.
        window.addFlags(
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
                    or WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
                    or WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
        )

        auth = FirebaseAuth.getInstance()
        db = FirebaseFirestore.getInstance()

        val word = intent.getStringExtra(Intent.EXTRA_PROCESS_TEXT) ?: ""
        val currentUser = auth.currentUser

        if (currentUser != null) {
            if (word != "") {
                val userId = currentUser.uid.toString()
                Log.i("Auth", "Oturum açan kullanıcı Id: $userId")

                val wordMap = hashMapOf(
                    "wordId" to "",
                    "word" to word,
                    "translatedWords" to arrayListOf<String>(),
                    "color" to rnd.toString(),
                    "score" to 0
                )

                db.collection("users").document(userId).collection("words").add(wordMap).addOnSuccessListener { documentReference ->
                    db.collection("users").document(userId).collection("words").document(documentReference.id).update(hashMapOf("wordId" to documentReference.id) as Map<String, Any>).addOnSuccessListener {

                        runOnUiThread {
                            Toast.makeText(applicationContext, "$word eklendi ", Toast.LENGTH_LONG).show()
                        }

                        finishAffinity()
                    }.addOnFailureListener { exception ->
                        Log.i("Cw Error", exception.message.toString())
                        finishAffinity()
                    }
                }.addOnFailureListener { exception ->
                    Log.i("Cw Error", exception.message.toString())
                    finishAffinity()
                }
            }
        } else {
            Toast.makeText(applicationContext, "Colorword uygulamasında oturum açın. Ardından tekrar deneyin.", Toast.LENGTH_LONG).show()
            finishAffinity()
        }
    }

        fun randomHexColor(): String {
    val random = Random.Default
    val color = java.lang.String.format("#%06X", 0xFFFFFF and random.nextInt(0x1000000))
    return color
}
    
}

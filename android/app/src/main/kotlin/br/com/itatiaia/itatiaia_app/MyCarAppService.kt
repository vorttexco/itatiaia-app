package br.com.itatiaia.itatiaia_app

import androidx.car.app.CarAppService
import androidx.car.app.validation.HostValidator
import androidx.car.app.Session
import androidx.car.app.Screen
import android.content.Intent

class MyCarAppService : CarAppService() {
    override fun createHostValidator(): HostValidator {
        return HostValidator.ALLOW_ALL_HOSTS_VALIDATOR // Durante o desenvolvimento, permite qualquer host
    }

    override fun onCreateSession(): Session {
        return object : Session() {
            override fun onCreateScreen(intent: Intent): Screen {
                // Start with the WelcomeScreen
                return WelcomeScreen(carContext)
            }
        }
    }
}

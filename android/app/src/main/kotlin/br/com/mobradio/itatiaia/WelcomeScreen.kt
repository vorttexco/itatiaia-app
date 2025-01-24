package br.com.mobradio.itatiaia

import androidx.car.app.Screen
import androidx.car.app.model.MessageTemplate
import androidx.car.app.model.Template
import androidx.car.app.CarContext

class WelcomeScreen(carContext: CarContext) : Screen(carContext) {
    override fun onGetTemplate(): Template {
        return MessageTemplate.Builder("Abra o aplicativo no seu celular para ouvir sua rádio!")
            .setTitle("Itatiaia")
            .build()
    }
}

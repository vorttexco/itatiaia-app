package br.com.mobradio.itatiaia

import android.util.Log
import androidx.car.app.Screen
import androidx.car.app.model.Action
import androidx.car.app.model.GridItem
import androidx.car.app.model.GridTemplate
import androidx.car.app.model.Template
import androidx.core.graphics.drawable.IconCompat
import androidx.car.app.model.CarIcon
import androidx.car.app.model.ItemList
import androidx.car.app.CarContext
import android.media.MediaPlayer
import android.media.AudioManager
import android.media.AudioAttributes

class WelcomeScreen(carContext: CarContext) : Screen(carContext) {
    private val mediaPlayer = MediaPlayer()
    
    override fun onGetTemplate(): Template {
        // Create the grid items
        val gridItem1 = GridItem.Builder()
            .setTitle("Belo Horizonte")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://8903.brasilstream.com.br/stream")
            }
            .build()

        val gridItem2 = GridItem.Builder()
            .setTitle("Juiz de Fora")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://live.paineldj.com.br/proxy/itatiaia?mp=/stream")
            }
            .build()

        val gridItem3 = GridItem.Builder()
            .setTitle("Montes Claros")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://9607.brasilstream.com.br/stream?origem=site_oficial")
            }
            .build()

        val gridItem4 = GridItem.Builder()
            .setTitle("Outo Preto")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://8002.brasilstream.com.br/stream")
            }
            .build()

        val gridItem5 = GridItem.Builder()
            .setTitle("Vale do Aço")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://radio.saopaulo01.com.br:7000/stream")
            }
            .build()

        val gridItem6 = GridItem.Builder()
            .setTitle("Varginha")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream("https://stm01.virtualcast.com.br:8002/itatiaiasulminas?tid=01GQN8H8MDSGQTH6XCTKPM06GS")
            }
            .build()

        val itemList = ItemList.Builder()
            .addItem(gridItem1)
            .addItem(gridItem2)
            .addItem(gridItem3)
            .addItem(gridItem4)
            .addItem(gridItem5)
            .addItem(gridItem6)
            .build()
        
        return GridTemplate.Builder()
            .setTitle("Selecione sua rádio")
            .setHeaderAction(Action.APP_ICON)
            .setSingleList(itemList)
            .build()
    }

    fun playSong(songUrl: String) {
        try {
            mediaPlayer.reset()
            mediaPlayer.setDataSource(songUrl)
            mediaPlayer.prepare()
            mediaPlayer.start()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun playStream(streamUrl: String) {
        try {
            mediaPlayer.reset()
            mediaPlayer.setDataSource(streamUrl)
    
            // Set the audio attributes for modern API levels
            val audioAttributes = AudioAttributes.Builder()
                .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                .setUsage(AudioAttributes.USAGE_MEDIA)
                .build()
    
            mediaPlayer.setAudioAttributes(audioAttributes)
    
            mediaPlayer.setOnPreparedListener {
                it.start()
            }
            mediaPlayer.prepareAsync() // Prepare asynchronously for streams
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
    
}

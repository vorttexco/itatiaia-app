package br.com.mobradio.itatiaia

// import android.util.Log
// import androidx.car.app.Screen
// import androidx.car.app.model.Action
// import androidx.car.app.model.GridItem
// import androidx.car.app.model.GridTemplate
// import androidx.car.app.model.Template
// import androidx.core.graphics.drawable.IconCompat
// import androidx.car.app.model.CarIcon
// import androidx.car.app.model.ItemList
// import androidx.car.app.CarContext
// import androidx.media3.exoplayer.ExoPlayer
// import androidx.media3.common.MediaItem
import android.content.Context
import android.media.AudioAttributes
import android.media.AudioFocusRequest
import android.media.AudioManager
import android.util.Log
import androidx.car.app.CarContext
import androidx.car.app.Screen
import androidx.car.app.model.Action
import androidx.car.app.model.GridItem
import androidx.car.app.model.GridTemplate
import androidx.car.app.model.Template
import androidx.core.graphics.drawable.IconCompat
import androidx.car.app.model.CarIcon
import androidx.car.app.model.ItemList
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.common.PlaybackException
import androidx.media3.exoplayer.ExoPlayer

class WelcomeScreen(carContext: CarContext) : Screen(carContext) {
    private var exoPlayer: ExoPlayer? = null
    
    private val audioManager: AudioManager = carContext.getSystemService(Context.AUDIO_SERVICE) as AudioManager
    private var audioFocusRequest: AudioFocusRequest? = null
    private val audioFocusListener = AudioManager.OnAudioFocusChangeListener { focusChange ->
        when (focusChange) {
            AudioManager.AUDIOFOCUS_LOSS -> {
                exoPlayer?.pause()
                abandonAudioFocus()
            }
            AudioManager.AUDIOFOCUS_LOSS_TRANSIENT -> exoPlayer?.pause()
            AudioManager.AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK -> exoPlayer?.volume = 0.1f
            AudioManager.AUDIOFOCUS_GAIN -> {
                exoPlayer?.volume = 1.0f
                exoPlayer?.play()
            }
        }
    }

    init {
        initializePlayer()
    }

    fun initializePlayer() {
        if (exoPlayer == null) {
            exoPlayer = ExoPlayer.Builder(carContext).build().apply {
                // Configurações adicionais do player
                playWhenReady = false
                addListener(object : Player.Listener {
                    override fun onPlayerError(error: PlaybackException) {
                        Log.e("WelcomeScreen", "Erro no player: ${error.message}")
                    }
                })
            }
        }
    }



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
                playStream(carContext, "https://8903.brasilstream.com.br/stream")
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
                playStream(carContext, "https://live.paineldj.com.br/proxy/itatiaia?mp=/stream")
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
                playStream(carContext, "https://9607.brasilstream.com.br/stream?origem=site_oficial")
            }
            .build()

        val gridItem4 = GridItem.Builder()
            .setTitle("Ouro Preto")
            .setImage(
                CarIcon.Builder(
                    IconCompat.createWithResource(carContext, R.drawable.ic_stat_onesignal_default)
                ).build(),
                GridItem.IMAGE_TYPE_LARGE
            )
            .setOnClickListener {
                playStream(carContext, "https://8002.brasilstream.com.br/stream")
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
                playStream(carContext, "https://radio.saopaulo01.com.br:7000/stream")
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
                playStream(carContext, "https://stm01.virtualcast.com.br:8002/itatiaiasulminas?tid=01GQN8H8MDSGQTH6XCTKPM06GS")
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

    fun playStream(context: CarContext, streamUrl: String) {
        // initializePlayer();

        val focusRequest = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN)
            .setAudioAttributes(
                AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_MEDIA)
                    .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                    .build()
            )
            .setOnAudioFocusChangeListener(audioFocusListener)
            .build()

        val result = audioManager.requestAudioFocus(focusRequest)
        
        if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
            exoPlayer?.let { player ->
                try {
                    player.setMediaItem(MediaItem.fromUri(streamUrl))
                    player.prepare()
                    player.play()
                    audioFocusRequest = focusRequest
                } catch (e: Exception) {
                    Log.e("WelcomeScreen", "Erro ao reproduzir stream: ${e.message}")
                }
            }
        } else {
            Log.e("WelcomeScreen", "Falha ao obter audio focus")
        }
        
        // if (exoPlayer == null) {
        //     exoPlayer = ExoPlayer.Builder(context).build()
        // }
    
        // val mediaItem = MediaItem.fromUri(streamUrl)
        // exoPlayer?.apply {
        //     setMediaItem(mediaItem)
        //     prepare()
        //     play()
        // }
    }

    private fun abandonAudioFocus() {
        audioFocusRequest?.let {
            audioManager.abandonAudioFocusRequest(it)
            audioFocusRequest = null
        }
    }
    
}

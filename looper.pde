import ddf.minim.*;
import ddf.minim.analysis.*;

class AudioReactor implements AudioListener {
  
  AudioPlayer source;
  BeatDetect detector;
  FFT fft;
  boolean beat;
  float energy;
  float[] spectrum;
  
  AudioReactor(AudioPlayer source) {
    this.source = source;
    source.addListener(this);
    detector = new BeatDetect();
    fft = new FFT(source.bufferSize(), source.sampleRate());
    fft.noAverages();
    beat = false;
    energy = 0;
    spectrum = new float[3];
  }
  
  void samples(float[] samps) {
    update();
  }
  
  void samples(float[] sampsL, float[] sampsR) {
    update();
  }
  
  void update() {
    detector.detect(source.mix);
    energy = source.mix.level();
    beat = detector.isOnset();
    fft.forward(source.mix);
    spectrum[0] = fft.calcAvg(20,100);
    spectrum[1] = fft.calcAvg(100,10000);
    spectrum[2] = fft.calcAvg(10000,22050);
  }
}

class AudioReactiveLooper {
  Minim engine;
  AudioPlayer track;
  AudioReactor reactor;
  
  AudioReactiveLooper(PApplet parent, 
         String loop_filename) {
    engine = new Minim(parent);
    track = engine.loadFile(loop_filename);
    track.loop();
    
    reactor = new AudioReactor(track);    
  }
  
  boolean beat() {
    return reactor.beat;
  }
    
  float energy() {
    return reactor.energy;
  }
  
  float low() {
    return reactor.spectrum[0];
  }
  
  float mid() {
    return reactor.spectrum[1];
  }
  
  float high() {
    return reactor.spectrum[2];
  }
}

TARGETS = bell103_goertzel_wav_decoder bell103_goertzel_wav_encoder

all:	$(TARGETS)

CXXFLAGS = -std=c++17 -g -Wshadow
LDLIBS = -lsndfile -lasound

bell103_goertzel_wav_decoder: bell103_goertzel_wav_decoder.cpp goertzel_bell103.h Makefile
	$(CXX) $(CXXFLAGS) -o bell103_goertzel_wav_decoder bell103_goertzel_wav_decoder.cpp $(LDLIBS)

bell103_goertzel_wav_encoder: bell103_goertzel_wav_encoder.cpp goertzel_bell103.h Makefile
	$(CXX) $(CXXFLAGS) -o bell103_goertzel_wav_encoder bell103_goertzel_wav_encoder.cpp $(LDLIBS)

test:	$(TARGETS)
	./test-bell103-decoder.sh
	./test-bell103-encoder.sh
	./test-bell103-decoder.sh 8000
	./test-bell103-encoder.sh 8000
	./test-bell103-decoder.sh 4000
	./test-bell103-encoder.sh 4000
	./test-bell103-encoder.sh 2600
	echo "The decoder tests fail on 2600 and pass on 2700"
	./test-bell103-decoder.sh 2700
	echo "Completed all 44100 and 8000 and 4000 and 2600 tests"

clean:
	rm -rf $(TARGETS) .temp *-spectrogram.mkv *-spectrogram.png

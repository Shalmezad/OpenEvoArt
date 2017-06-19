run:
	ruby lib/openevoart.rb
montage:
	#montage out/art/*.png -geometry 144x90 montage.png
	montage out/art/*.png -geometry 24x15 out/montage.png
	#montage *.png -geometry 144x90 montage.png
movie:
	./dont_commit_crossfade.sh

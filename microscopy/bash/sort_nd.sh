NDS=$(ls|grep "\.nd")
echo $NDS
for i in $NDS
do
	FILENAME="${i%.*}"
	mkdir "$FILENAME"
	mv ${FILENAME}_w* "$FILENAME"
	mv $i "$FILENAME"
done
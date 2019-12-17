if [ $# -eq 0 ]
  then
    echo "Usage: bash rename_nd.sh new_name old_name.nd"
	exit 0
fi

NDS=($(ls|grep "\.nd"))
i=${NDS[0]}
if [ "${#NDS[@]}" -ne 1 ];
then
	  echo "There must be only one nd file";
	  exit;
  fi  
  
FILENAME="${i%.*}"



for file in ${FILENAME}*
do
	echo "$file --> ${file/$FILENAME/$1}"
done

read -p "Are you sure you want to continue? <y/N> " prompt
if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
then
	for file in ${FILENAME}*
	do
		mv "$file" "${file/$FILENAME/$1}"
	done  
else
  exit 0
fi




#This function will rename files according to a key
#Sample.txt is text file with the names of the current files and the new filenames
#the read function will split the columns of the Sample.txt file into fields
#Specify delimiter with IFS= before the read command.
#prepare text file in text Wrangler, to specify UNIX line endings

while read treat Id filename
do
 mv $Id.txt $filename.txt
done < Sample.txt


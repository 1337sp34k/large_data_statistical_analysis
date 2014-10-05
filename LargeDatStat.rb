#this program will iterate through the large dat set of methane levels since 1979.
puts "This program will iterate through a chart of Methane levels since 1979. It will show the standard deviation, mean and make a new csv file with the z-scores as a seperate column." #Inform user on goals and purpose of program
f = File.open("Methane.csv", "r") #open the file
datainfl = f.readlines.map{ |rows| rows.split(",")}.map { |inner| inner.drop(1).map{|x| x.to_f}}.transpose #make input data usable by splitting into sperate arrays, changing from string to float, and getting riid of unused numbers.
f.close

def calc_stats(anArray)
	mean = anArray.reduce(:+) / anArray.length #calculate mean
	standev = Math.sqrt(anArray.map{ |datval| (datval-mean)**2}.reduce(:+)/(anArray.length-1)) #calculate standard deviation
	zscore = anArray.map{ |val| (val-mean)/standev} #calculate z-score
	return mean, standev, zscore #return the vales
end

mean, standev, zscore = calc_stats(datainfl[0])
puts "The mean is " + mean.to_s #output mean
puts "The standard deviation is " + standev.to_s #output standard deviation 


f = File.open("Methanezscore.csv", "w")   #open the file to write the z scores to
newValsToWrite = datainfl[0].zip(zscore).map{ |vals| vals.join(",")}.join("\r\n") #add the z scores to the array, format it, and change from float to string
f.write(newValsToWrite)  #write the new values to the new file
f.close
puts "The file containing the z scores is called Methanezscore.csv" #tell user name of file so they can find it and view it if they so desire
puts "Here are the z-scores with their coresponding values: \r\n" + newValsToWrite #output the z scores witn their coresponding values.

After creating the container image, You might not be able to log into the application so you can directly inject your superuser credentials using the docker command. 
use this command after the app starts to run

Docker command: docker exec -it go-allinone-backend ./pocketbase superuser upsert naruto@admin.com 'Naruto-Hinata'

and after hitting this command, it will give an output: """ Successfully saved superuser "naruto@admin.com"! """ and you can login to the ui page using this creds. 

Thank you!!

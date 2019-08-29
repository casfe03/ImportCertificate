java -jar maven-repository-provisioner-1.4.2-SNAPSHOT-jar-with-dependencies.jar -a "activation:activation:*:1.0.2" -t "http://172.16.2.73:8081/nexus/repository/apache-maven/" -u admin -p admin123 -s "http://maven/nexus/repository/apache-maven/" -su tecnisys -sp tecnisys
	 
	 
	 sudo docker tag myimage registry/desenvolvimento/incom:tag
	 
	 
	 mvn clean -U package -Dproject.build.sourceEncoding=ISO-8859-1
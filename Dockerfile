FROM tomcat:9.0.65-jdk17-corretto
COPY target/maven-web-application.war /usr/local/tomcat/webapps/maven-web-application.war

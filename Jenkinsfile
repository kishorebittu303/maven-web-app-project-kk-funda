pipeline {
    agent any

    environment {
        TOMCAT_USER = 'bittu'
        TOMCAT_PASS = 'bittu'
        TOMCAT_HOST = 'http://13.61.148.150:8080'
        WAR_FILE    = 'target/maven-web-application.war'
    }

    tools {
        maven "maven3.9.9"
    }

    stages {
        stage('vcs') {
            steps {
                git branch: 'development',
                    credentialsId: '1a0b9413-034f-4592-9a97-116fb115ae6a',
                    url: 'https://github.com/kishorebittu303/maven-web-app-project-kk-funda.git'
            }
        }

        stage('compile') {
            steps {
                sh 'mvn compile'
            }
        }

        stage('sonar-qube-reports') {
            steps {
                sh 'mvn clean sonar:sonar package'
            }
        }

        stage('sending to jfrog') {
            steps {
                sh 'mvn clean deploy'
            }
        }

        stage('deploying-to-tomcat') {
            steps {
                sh """
                curl -u ${TOMCAT_USER}:${TOMCAT_PASS} \
                    --upload-file "${WAR_FILE}" \
                    "${TOMCAT_HOST}/manager/text/deploy?path=/myapp&update=true"
                """
            }
        }
    }

  post {
    always {
        slackSend (
            channel: '#mani',
,
            message: "Build ${env.JOB_NAME} #${env.BUILD_NUMBER} finished with status: ${currentBuild.currentResult}",
            color: currentBuild.currentResult == 'SUCCESS' ? 'good' : 'danger'
        )
    }
}

}


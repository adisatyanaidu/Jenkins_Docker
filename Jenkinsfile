#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
                            API_SERVER='http://10.224.90.113:8090'                 
                            API_AUTH_USER='YWRpeC5zYXR5YS5wZXJ1Lm5haWR1LnBlbnRha290YUBpbnRlbC5jb20='
                            API_AUTH_KEY='S2FydGhpa2V5YUAyMDIz'   
                            IMG_TAG='1.112'
                            CURRENT_DATE = '2022_06_07_08_51_53'
                            PROJECT_NAME = "managed-services-docker-image" 
 
    }
    stages {

        stage('Build Docker') {
             environment {
               FNAME = "Naive_local" 
            }
            steps {
                    script{  
                        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                    sh '''    
                            API_TOKEN_RES=$(curl --location --request POST "${API_SERVER}/v1/auth/token" --header 'Authorization: Bearer' --header 'Content-Type: application/json' --data-raw '{ "username":"'"${API_AUTH_USER}"'","password":"'"${API_AUTH_KEY}"'"}' )
                            API_TOKEN=$(echo ${API_TOKEN_RES} | jq -r '.token' )
                            API_DKR=$(curl --location --request POST "${API_SERVER}/v1/build/docker" -H "Authorization: Bearer $API_TOKEN" --header 'Content-Type: application/json' --data-raw '{ "githubUrl":"'"${API_URL}"'","imageName":"'"${API_NAME}"'","dockerfileLocation":"'"${DKR_LKT}"'","branch":"'"${API_BRNCH}"'","imageTag":"'"${IMG_TAG}"'"}' )
                            STATUS_ID=$(echo ${API_DKR} | jq -r '.statusId')
                            API_STS=$(curl --location --request GET "${API_SERVER}/v1/status/${STATUS_ID}" -H "Authorization: Bearer $API_TOKEN" --header 'Content-Type: application/json')
                            resp3=$(echo ${API_STS} | jq -r '.status')
                            echo "tags_extra: ${resp3}"
                            if [ $resp3 = Queued ]
then
         sleep 220
   resp4=$(curl -s $API_SERVER/v1/status/${STATUS_ID} -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $API_TOKEN" | jq -r '.status')    
    echo BUILD **** $resp4
    resp5=$(curl -s $API_SERVER/v1/status/${STATUS_ID} -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $API_TOKEN" | jq -r '.reports')
    echo **** Reports **** $resp4
    fi
         if [ $resp4 = Success ];then
            echo "******Docker Build JOB Success********" 
                    else {
                   echo "******Docker Build JOB Failed********"
                    }                  
             fi
     					'''
					           }
            }
        }
                    post {
                    success {
                        echo '*** API Handshake successfull'
                    }                            
                    failure {
                        echo '*** Exception occured while trying to connect to API Server '  
                        error("This will fail")
                    }  
                }
        }
                    stage('Get Reports'){
                steps{
                    sh '''
                        ARTIFACTORY_LINK="https://ubit-artifactory-or.intel.com/artifactory/software-recipes-or-local/scan-reports/${PROJECT_NAME}/${CURRENT_DATE}"
                        echo "All the scan reports are available at ${ARTIFACTORY_LINK}"
                        JSON_INPUT_LINKTS='{"artifacts": {"antivirus_reports": "'"${ARTIFACTORY_LINK}"'/antivirus_report.txt","trivy_report": "'"${ARTIFACTORY_LINK}"'/trivy_report.txt", "snyk": "'"${ARTIFACTORY_LINK}"'/snyk.zip", "bdba_report": "'"${ARTIFACTORY_LINK}"'/bdba_report.pdf"}}'
                        JSON_OUT=$(echo ${JSON_INPUT_LINKTS}|jq . > BuildDockerScanReportLinks.txt)                
                    '''
                }
            }

        /*        stage('stage two') {
            steps {
                echo "repo dir is testtt"
                  echo "tags_extra: ${API_NAME}"
            }
        }*/
    }
      post{
            success {                
                archiveArtifacts artifacts: 'trivy_report.txt, antivirus_report.txt, snyk.zip, bdba_report.pdf, BuildDockerScanReportLinks.txt'  
                echo '*** Artifact successfull'              
            }
            failure {
echo '*** Artifact Fail'
            }
      }
}

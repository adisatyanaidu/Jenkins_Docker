pipeline {
    agent any

    stages {
        stage("Using curl example") {
            steps {
                script {
                   final String statusId = '1337'
                   final String token = '-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJwYXNwbmFpeCIsImVtYWlsSWQiOiJhZGl4LnNhdHlhLnBlcnUubmFpZHUucGVudGFrb3RhQGludGVsLmNvbSIsInJvbGUiOiJwYWNrYWdlTWFuYWdlciIsImlhdCI6MTY1Mzk5ODAxNiwiZXhwIjoxNjU0MDAxNjE2LCJpc3MiOiJtc2EifQ.ep71hCP8FyLaqx0Edefgzyl0CAz4bWUksEUbFq9SFAY"'
                    final String url = 'http://10.224.90.113:8090/v1/status'
                    final String opt = '-X GET -H "Content-Type: application/json"'
                   final String response = sh """ curl -k http://10.224.90.113:8090/v1/auth/token -X POST -H "Content-Type: application/json" --data '{\"username\":\"YWRpeC5zYXR5YS5wZXJ1Lm5haWR1LnBlbnRha290YUBpbnRlbC5jb20=\",\"password\":\"S2FydGhpa2V5YUAyMDIz\"}' """
final String response2 = sh """ curl -k http://10.224.90.113:8090/v1/build/docker/ -X POST -H "Content-Type: application/json" -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJwYXNwbmFpeCIsImVtYWlsSWQiOiJhZGl4LnNhdHlhLnBlcnUubmFpZHUucGVudGFrb3RhQGludGVsLmNvbSIsInJvbGUiOiJwYWNrYWdlTWFuYWdlciIsImlhdCI6MTY1Mzk5ODAxNiwiZXhwIjoxNjU0MDAxNjE2LCJpc3MiOiJtc2EifQ.ep71hCP8FyLaqx0Edefgzyl0CAz4bWUksEUbFq9SFAY" --data '{\"githubUrl\":\"https://github.com/intel-innersource/applications.services.esh.dse-automation-esh\",\"imageName\":\"testqacurl\"}' """
                   
              final String response3 = sh(script: "curl -s $url/$statusId $opt $token", returnStdout: true).trim()  
                  
                   echo response3
                }
            }
        }
    }
}

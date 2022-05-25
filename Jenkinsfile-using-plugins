pipeline
{
    environment
    {
        IMAGE = 'a7medayman6/goviolin'
        DOCKERHUB_CREDENTIALS = 'dockerhub'
        DOCKER_IMAGE = ''
        K8S_DEPLOYMENT_FILE = 'deployment.yaml'
        K8S_SERVICE = 'goviolin-service'
    }
    agent any
    stages
    {
        stage('Build')
        {
            steps
            {       
                script
                {
                    try
                    {
                        DOCKER_IMAGE = docker.build IMAGE
                        echo 'Sending Success Mail to a.ayman6000@gmail.com ....'
                        echo ''
                        mail bcc: '', body: 'Your Build Stage in pipeline for GoViolin has been successfully build.', cc: '', from: '', replyTo: '', subject: 'Successful Build - GoViolin Pipeline', to: 'a.ayman6000@gmail.com'
                        echo 'Mail Sent.'
                    }
                    catch(all)
                    {
                        echo 'Sending Success Mail to a.ayman6000@gmail.com ....'
                        echo ''
                        mail bcc: '', body: 'Your Build Stage in pipeline for GoViolin has been successfully build.', cc: '', from: '', replyTo: '', subject: 'Successful Build - GoViolin Pipeline', to: 'a.ayman6000@gmail.com'
                        echo 'Mail Sent.'
                    }
                }          
            }
        }
        
        stage('Push')
        {
            steps
            {
                script
                {
                    try
                    {
                        docker.withRegistry( '', DOCKERHUB_CREDENTIALS) 
                        {
                            DOCKER_IMAGE.push('latest')
                        }
                        mail bcc: '', body: 'Your Push Stage in pipeline for GoViolin has been successfully executed.', cc: '', from: '', replyTo: '', subject: 'Successful Build - GoViolin Pipeline', to: 'a.ayman6000@gmail.com'
                    }
                    catch(all)
                    {
                        mail bcc: '', body: 'Your Push Stage in pipeline for GoViolin has Failed, Please Review the stage.', cc: '', from: '', replyTo: '', subject: 'Build Failed - GoViolin Pipeline', to: 'a.ayman6000@gmail.com'
                    }
                }
            }
        }
        
        stage('Deploy to Kubernetes')
        {
            steps
            {
                script
                {
                    sh "kubectl apply -f ./${K8S_DEPLOYMENT_FILE}"
                    
                    echo 'Sending Success Mail to a.ayman6000@gmail.com ....'
                    echo ''
                    mail bcc: '', body: 'Successful Deployement on Kubernetes. To get the Web App URL RUN "minikube service goviolin-service --url" - GoViolin Pipeline', cc: '', from: '', replyTo: '', subject: 'GoViolin Has been Successfully Deployed on K8s.', to: 'a.ayman6000@gmail.com'
                    echo 'Mail Sent.'
                }
            }
        }
       
    }
    post
    {
        always
        {
            echo 'Finished.'
        }
    }
}
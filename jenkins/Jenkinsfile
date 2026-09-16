pipeline {
    agent any // Run this pipeline workflow on any available active Jenkins worker engine node.
              //  ಈ ಇಡೀ ಆಟೋಮೇಷನ್ ಕೆಲಸವನ್ನು ಲಭ್ಯವಿರುವ ಯಾವುದೇ ಜೆಂಕಿನ್ಸ್ ವರ್ಕರ್ ಸರ್ವರ್‌ನಲ್ಲಿ ರನ್ ಮಾಡಿ.

    environment {
        AWS_ACCOUNT_ID = '439855819605' // Replace this placeholder string with your actual 12-digit AWS Account ID.
                                        // ಈ ಜಾಗದಲ್ಲಿ ನಿಮ್ಮ ಸ್ವಂತ 12-ಅಂಕಿಗಳ AWS ಅಕೌಂಟ್ ಐಡಿಯನ್ನು ಹಾಕಿ.
        
        AWS_DEFAULT_REGION = 'us-east-1' // Target cloud region hosting our infrastructure registry layout.
                                         // ನಮ್ಮ ಕ್ಲೌಡ್ ಸರ್ವರ್ ಚಾಲ್ತಿಯಲ್ಲಿರುವ AWS ನ ಡೇಟಾ ಸೆಂಟರ್ ರೀಜನ್ ಐಡಿ.
        
        IMAGE_REPO_NAME = 'fintech-app-registry' // Private storage repository identifier matching Terraform specs.
                                                 // ನಾವು ಟೆರಾಫಾರ್ಮ್ ಕೋಡ್‌ನಲ್ಲಿ ನಿಗದಿಪಡಿಸಿದ AWS ECR ನ ಹೆಸರು.
    }

    stages {
        stage('1. Fetch Source Code') { 
            //  Downloads the latest engineering commit payload from GitHub version control.
            // ಗಿಟ್‌ಹಬ್ ರೆಪೊಸಿಟರಿಯಿಂದ ಹೊಸ ಕೋಡ್ ಅನ್ನು ಜೆಂಕಿನ್ಸ್ ಪರಿಸರಕ್ಕೆ ಡೌನ್‌ಲೋಡ್ ಮಾಡುವ ಹಂತ.
            steps {
                checkout scm //  Automatically synchronizes code paths from the configured remote repository branch hooks.
                             //  ಈ ಜಾಬ್‌ಗೆ ಕನೆಕ್ಟ್ ಆಗಿರುವ ಗಿಟ್‌ಹಬ್ ბ್ರಾಂಚ್‌ನಿಂದ ಹೊಸ ಕೋಡ್ ಫೈಲ್‌ಗಳನ್ನು ಆಟೋಮ್ಯಾಟಿಕ್ ಆಗಿ ಪುಲ್ ಮಾಡುತ್ತದೆ.
            }
        }

        stage('2. Execute Quality Validation') { 
            // Gatekeeper phase that runs unit tests inside the app subfolder to stop broken systems from building.
            // ಅಪ್ಲಿಕೇಶನ್ ಲಾಜಿಕ್‌ನಲ್ಲಿ ಯಾವುದೇ ತಪ್ಪುಗಳಿಲ್ಲ ಎಂದು `app` ಫೋಲ್ಡರ್ ಒಳಗೆ ಕೋಡ್ ಕ್ವಾಲಿಟಿ ಟೆಸ್ಟ್ ಮಾಡುವ ಹಂತ.
            steps {
                dir('app') {
                    sh 'python -m unittest test_app.py' // Runs the automated Python validation layer we verified locally.
                                                        //  ನಾವು ಹಿಂದಿನ ಹಂತದಲ್ಲಿ ಬರೆದು ಟೆಸ್ಟ್ ಮಾಡಿದ ಪೈಥಾನ್ ಟೆಸ್ಟಿಂಗ್ ಸ್ಕ್ರಿಪ್ಟ್ ಅನ್ನು ರನ್ ಮಾಡುತ್ತದೆ.
                }
            }
        }

        stage('3. Enforce Infrastructure State') { 
            // Target the terraform folder and applies infrastructure changes cleanly.
            // ಟೆರಾಫಾರ್ಮ್ ಫೋಲ್ಡರ್ ಒಳಗಡೆ ಪ್ರವೇಶಿಸಿ AWS ಕ್ಲೌಡ್ ಮೂಲಸೌಕರ್ಯವನ್ನು ಅಪ್ಡೇಟ್ ಮಾಡುವ ಹಂತ.
            steps {
                dir('terraform') {
                    sh 'terraform init' // Readies the module backend plugins to sync target parameters safely.
                                        //  ಟೆರಾಫಾರ್ಮ್ ಕೆಲಸ ಮಾಡಲು ಬೇಕಾದ ಪ್ಲಗಿನ್‌ಗಳನ್ನು ಬ್ಯಾಕ್‌ಗ್ರೌಂಡ್‌ನಲ್ಲಿ ಇನಿಶಿಯಲೈಸ್ ಮಾಡುತ್ತದೆ.
                    
                    sh 'terraform apply -auto-approve' //  Ensures our production cloud cluster reflects code parameters without prompt.
                                                       //  ಯಾವುದೇ ಮ್ಯಾನುಯಲ್ ಅಪ್ರೂವಲ್ ಇಲ್ಲದೆ AWS ರಿಸೋರ್ಸ್‌ಗಳನ್ನು ಆಟೋಮ್ಯಾಟಿಕ್ ಆಗಿ ಅಪ್ಲೈ ಮಾಡುತ್ತದೆ.
                }
            }
        }

        stage('4. Assemble Container & Push to AWS') { 
            // Navigate to the application directory to compile the Docker image and ship it to AWS ECR.
            // `app` ಫೋಲ್ಡರ್ ಒಳಗೆ ಪ್ರವೇಶಿಸಿ ಡಾಕರ್ ಇಮೇಜ್ ಬಿಲ್ಡ್ ಮಾಡಿ ಅದನ್ನು AWS ECR ಕ್ಲೌಡ್‌ಗೆ ಸುರಕ್ಷಿತವಾಗಿ ಕಳುಹಿಸುವ ಹಂತ.
            steps {
                dir('app') {
                    //  Authenticates local container engine directly with the secure remote private AWS ECR token registries.
                    //  ನಮ್ಮ AWS ಅಕೌಂಟ್‌ಗೆ ಕಂಟೈನರ್ ಕಳುಹಿಸಲು ಬೇಕಾದ ಡಾಕರ್ ಲಾಗಿನ್ ಪರ್ಮಿಷನ್ ಟೋಕನ್ ಅನ್ನು ಪಡೆದುಕೊಳ್ಳುತ್ತದೆ.
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                    
                    //  Assembles source patterns into a stable deployment image layered with unique runtime build counts.
                    // ನಮ್ಮ ಹೊಸ ಕೋಡ್ ಅನ್ನು ಬಳಸಿಕೊಂಡು ಒಂದು ಅಧಿಕೃತ ಡಾಕರ್ ಇಮೇಜ್ ಅನ್ನು ಬಿಲ್ಡ್ ಮಾಡುತ್ತದೆ.
                    sh "docker build -t ${IMAGE_REPO_NAME}:${BUILD_NUMBER} ."
                    
                    //  Remaps naming syntax schemas cleanly to match absolute cloud environment requirements.
                    //  ಆ ಬಿಲ್ಡ್ ಆದ ಡಾಕರ್ ಇಮೇಜ್‌ಗೆ AWS ನಿಯಮಗಳ ಪ್ರಕಾರ ಪ್ರತ್ಯೇಕವಾದ ಟ್ಯಾಗ್ ಐಡಿಯನ್ನು ನೀಡುತ್ತದೆ.
                    sh "docker tag ${IMAGE_REPO_NAME}:${BUILD_NUMBER} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}://{IMAGE_REPO_NAME}:${BUILD_NUMBER}"
                    
                    //  Elevates the verified software package into the secure AWS core registry clusters safely.
                    //  ರೆಡಿಯಾದ ಡಾಕರ್ ಇಮೇಜ್ ಆಸ್ತಿಯನ್ನು ಸುರಕ್ಷಿತವಾಗಿ AWS ECR ಕ್ಲೌಡ್ ಸ್ಟೋರೇಜ್‌ಗೆ ಅಪ್ಲೋಡ್ ಮಾಡುತ್ತದೆ.
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}://{IMAGE_REPO_NAME}:${BUILD_NUMBER}"
                }
            }
        }
    }
}

//https://medium.com/nerd-for-tech/deploying-aws-resources-using-terraform-and-jenkins-pipeline-1c706f1a2e7c

pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'terraform', description: 'Workspace/environment file to use for deployment')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        //booleanParam(name: 'destroy', defaultValue: false, description: 'Destroy Terraform build?')

    }

     environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        REGION = credentials('AWS_REGION')
    }

    stages {
        // stage('checkout') {
        //     steps {
        //          script{
        //                 dir("terraform")
        //                 {
        //                     git "https://github.com/kadawe/week-24-project.git"
        //                 }
        //             }
        //         }
        //     }

        stage('Plan') {
            // when {
            //     not {
            //         equals expected: true, actual: params.destroy
            //     }
            // }
            
            steps {
                sh 'terraform init -upgrade'
                //sh 'terraform init -input=false'
                //sh 'terraform workspace select ${environment} || terraform workspace new ${environment}'
                sh "terraform validate"
                sh "terraform plan"
                //sh "terraform plan -input=false -out tfplan"
                //sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval') {
           when {
               not {
                   equals expected: true, actual: params.autoApprove
               }
            //    not {
            //         equals expected: true, actual: params.destroy
            //     }
           }
           
           steps {
               script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
               }
           }
       }

        stage('Apply') {
            // when {
            //     not {
            //         equals expected: true, actual: params.destroy
            //     }
            // }
            
            steps {
                //sh "terraform apply -input=false tfplan"
                sh "terraform apply --auto-approve"
            }
        }
        
        // stage('Destroy') {
        //     when {
        //         equals expected: true, actual: params.destroy
        //     }
        
        // steps {
        //    sh "terraform destroy --auto-approve"
        // }
        //}

    }
}

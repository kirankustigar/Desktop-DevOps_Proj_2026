terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- NEW NETWORK CODE BLOCK STARTED (ಹೊಸ ನೆಟ್‌ವರ್ಕ್ ಕೋಡ್ ಇಲ್ಲಿದೆ) ---
# English: Automatically fetch the default network environment details from AWS.
# ಕನ್ನಡ: AWS ಅಕೌಂಟ್‌ನಲ್ಲಿರುವ ಡಿಫಾಲ್ಟ್ ನೆಟ್‌ವರ್ಕ್ ಮಾಹಿತಿಯನ್ನು ಆಟೋಮ್ಯಾಟಿಕ್ ಆಗಿ ಪಡೆದುಕೊಳ್ಳುವುದು.
resource "aws_default_vpc" "default" {}
# --- NEW NETWORK CODE BLOCK ENDED (ಹೊಸ ನೆಟ್‌ವರ್ಕ್ ಕೋಡ್ ಮುಗಿಯಿತು) ---

resource "aws_ecr_repository" "fintech_repo" {
  name                 = "fintech-app-registry"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_security_group" "fintech_sg" {
  name        = "fintech-app-sg"
  description = "Firewall rules for Fintech web application"
  
  # --- UPDATED LINE BELOW: Link the firewall to our network (ನೆಟ್‌ವರ್ಕ್‌ಗೆ ಲಿಂಕ್ ಮಾಡಲಾಗಿದೆ) ---
  vpc_id      = aws_default_vpc.default.id 

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "fintech_server" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"             
  
  vpc_security_group_ids = [aws_security_group.fintech_sg.id]

  tags = {
    Name        = "Fintech-Production-Server"
    Environment = "Production"
  }
}

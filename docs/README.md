# `/docs`

> Platform documentation.   

Project structure:   
```bash
infra-core/
├── assets/
│   ├── banners/
│   │   ├── banner.png
│   │   └── README.md
│   ├── diagrams/
│   │   └── README.md
│   ├── icons/
│   │   └── README.md
│   ├── misc/
│   │   └── README.md
│   ├── screenshots/
│   │   └── README.md
│   └── README.md
├── docs/
│   └── README.md
├── environments/
│   ├── production/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── README.md
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── README.md
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   ├── state_storage/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── random.tf
│   │   ├── README.md
│   │   ├── terraform.tfvars
│   │   └── variables.tf
│   └── README.md
├── .gitignore
├── LICENSE
└── README.md
```
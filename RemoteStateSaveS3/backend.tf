terraform {
	backend "s3"{
		bucket  = "config-backup-terraform"
		key 	= "terraform/backup"
	}
}

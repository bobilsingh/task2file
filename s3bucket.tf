resource "aws_s3_bucket" "image-bucket" {
    bucket  = "webserver-images321-bobilbucket"
    acl     = "public-read"


provisioner "local-exec" { 
        command     = "git clone https://github.com/bobilsingh/task2file.git"

}

provisioner "local-exec" {
        when        =   destroy
        command     =   "echo Yes | rmdir /s photo"
    }
}


resource "aws_s3_bucket_object" "image-upload" {
    content_type = "image/jpeg"
    bucket  = "${aws_s3_bucket.image-bucket.id}"
    key     = "download.jpeg"
    source  = "task2file/download.jpeg"
    acl     = "public-read"
}
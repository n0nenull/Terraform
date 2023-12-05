# Create a new Droplet using the SSH key
resource "digitalocean_droplet" "www-2" {
  image = "ubuntu-20-04-x64"
  name = "www-2"
  region = "nyc3"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.Terraform.id
  ]

  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file("/home/kali/git/Terraform/files/id_rsa")
  }
  
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx"
    ]
  }
}
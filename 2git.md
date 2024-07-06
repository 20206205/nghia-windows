<!--  -->

git clone https://github.com/vvn20206205/test2github

<!--  -->

Xóa thông tin github Control Panel

<!--  -->

ssh-keygen -t ed25519 -C "nghiavu2k2abc@gmail.com" -f ~/.ssh/vvn20206205
ssh-keygen -t ed25519 -C "nghiayeunguyenhong@gmail.com" -f ~/.ssh/hust20206205
ssh-keygen -t ed25519 -C "vuthingan30012000@gmail.com" -f ~/.ssh/company20206205
ssh-keygen -t ed25519 -C "vuvannghia452002@gmail.com" -f ~/.ssh/vuvannghia452002

<!--  -->

eval `ssh-agent -s`

<!-- eval "$(ssh-agent -s)" -->
<!--  -->


ssh-add ~/.ssh/vvn20206205
ssh-add ~/.ssh/hust20206205
ssh-add ~/.ssh/company20206205
ssh-add ~/.ssh/vuvannghia452002

<!--  -->


cd ~
touch .gitconfig
touch .gitconfig.vvn20206205
touch .gitconfig.hust20206205
touch .gitconfig.company20206205
touch .gitconfig.vuvannghia452002

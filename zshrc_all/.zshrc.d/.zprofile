# ~/.zshrc.d/.zprofile

# allow zshrc to do global setup if it wants
[[ -f ~/.zshrc.d/.zshrc ]] && source ~/.zshrc.d/.zshrc

# run the x11 login script
[[ -f ~/.dots/scripts/xlogin.sh ]] && source ~/.dots/scripts/xlogin.sh

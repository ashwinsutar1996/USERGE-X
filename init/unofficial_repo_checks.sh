# made by ashwinstr, under process

_checkUnoffPlugins() {
    editLastMessage "Checking USERGE-X [Extra] Plugins ..."
    if test $LOAD_UNOFFICIAL_PLUGINS = true; then
        editLastMessage "\tLoading USERGE-X [Extra] Plugins ..."
        replyLastMessage "\t\tClonning ashwinstr/Userge-Plugins.git ..."
        gitClone --depth=1 https://github.com/ashwinstr/Userge-Plugins.git
        editLastMessage "\t\tUpgrading PIP ..."
        upgradePip
        editLastMessage "\t\tInstalling Requirements ..."
        installReq Userge-Plugins
        editLastMessage "\t\tCleaning ..."
        rm -rf userge/plugins/unofficial/
        mv Userge-Plugins/plugins/ userge/plugins/unofficial/
        cp -r Userge-Plugins/resources/* resources/
        rm -rf Userge-Plugins/
        deleteLastMessage
        editLastMessage "\tUSERGE-X [Extra] Plugins Loaded Successfully !"
    else
        editLastMessage "\tUSERGE-X [Extra] Plugins Disabled !"
    fi
    deleteLastMessage
}

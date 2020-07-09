#KBRANCH ?= "${@find_branch_from_latest_tag(d)}"
#KBRANCH[vardepvalue] = ""
#do_kernel_checkout[vardepsexclude] = "KBRANCH STABLE_BRANCH"
#do_kernel_metadata[vardepsexclude] = "KBRANCH STABLE_BRANCH"
#do_validate_branches[vardepsexclude] = "KBRANCH STABLE_BRANCH"

python do_find_dev_bkc_branch() {
    import re
    src_uri = d.getVar('SRC_URI').split()[0]
    ud = bb.fetch2.FetchData(src_uri, d)
    output = ud.method._lsremote(ud, d, "refs/tags/dev-bkc-embargoed-*^{}")
    
    verstring = ""
    pupver = ('', '', '')
    for line in output.split("\n"):
        if not line:
            break
        tagregex = re.compile("(?P<ver>\d+w\d+\.\d+-\d+).*$")
        tag_head = line.split("/")[-1]

        # search for version in the line
        tag = tagregex.search(tag_head)
        if tag == None:
            continue

        tag = tag.group('ver')
        tag = tag.replace("-", ".")

        if verstring and bb.utils.vercmp(("0", tag, ""), ("0", verstring, "")) < 0:
            continue

        verstring = tag
        pupver = (verstring, line.split()[0], line.split()[1])
    try:
        bb.note("Linux-Intel Dev-BKC looking for %s" % (pupver[2]))
        cmd = "%s branch -a --contains %s --list 'staging/*'" % (ud.basecmd, pupver[1])
        wd = d.getVar('S')
        branch = bb.fetch2.runfetchcmd(cmd, d, quiet=True, workdir=wd).strip("* \n\r")

        bb.note("Linux-Intel Dev-BKC is using %s" % (branch))

        # Now Check it out
        cmd = "%s checkout -f %s" % (ud.basecmd, branch)
        branch = bb.fetch2.runfetchcmd(cmd, d, quiet=True, workdir=wd).strip("* \n\r")
    except:
        bb.note("Linux-Intel Dev-BKC is using default")
}

addtask find_dev_bkc_branch before do_kernel_metadata after do_kernel_checkout


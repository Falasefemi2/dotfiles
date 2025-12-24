local dap = require("dap")

dap.adapters.go = {
    type = "executable",
    command = "dlv",
    args = { "dap" },
}

dap.configurations.go = {
    {
        type = "go",
        name = "Attach",
        mode = "local",
        request = "attach",
        processId = require("dap.utils").pick_process,
        showLog = false,
    },
    {
        type = "go",
        name = "Debug",
        mode = "debug",
        request = "launch",
        program = "${fileDirname}",
        env = {},
        args = {},
    },
}

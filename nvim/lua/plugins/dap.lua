return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
    },
    config = function()
        local dap = require("dap")

        require("dap-go").setup()

        dap.configurations.go = {
            {
                type = "go",
                name = "Debug Main",
                request = "launch",
                mode = "debug",
                program = "${fileDirname}",
                cwd = "${fileDirname}",
            },
            {
                type = "go",
                name = "Debug Test (Package)",
                request = "launch",
                mode = "test",
                program = "${fileDirname}",
                cwd = "${fileDirname}",
            },
        }
    end,
}

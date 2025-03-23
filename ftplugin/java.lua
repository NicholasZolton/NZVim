-- local function list_files_in_directory(directory)
--   local i, t, popen = 0, {}, io.popen
--   local pfile = popen('ls "' .. directory .. '"')
--   for filename in pfile:lines() do
--     i = i + 1
--     t[i] = filename
--   end
--   pfile:close()
--   return t
-- end
--
-- local function find_launcher_jar(directory)
--   local files = list_files_in_directory(directory)
--   for _, file in ipairs(files) do
--     if file:match "launcher%.jar$" then
--       return directory .. "/" .. file
--     end
--   end
--   return nil
-- end

local jdtls = require "jdtls"
local jdtls_dap = require "jdtls.dap"
local jdtls_setup = require "jdtls.setup"
local home = os.getenv "HOME"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls_setup.find_root(root_markers)

local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name

local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"
local path_to_jdtls = path_to_mason_packages .. "/jdtls"
local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
local path_to_jtest = path_to_mason_packages .. "/java-test"

local path_to_config = path_to_jdtls .. "/config_linux"
local lombok_path = path_to_jdtls .. "/lombok.jar"

-- local path_to_jar = find_launcher_jar(path_to_jdtls)
local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"

local bundles = {
  vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))

-- LSP settings for Java.
local on_attach = function(_, bufnr)
  jdtls.setup_dap()
  jdtls_dap.setup_dap_main_class_configs()

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  local map = vim.keymap.set
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end

local capabilities = {
  workspace = {
    configuration = true,
  },
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
      },
    },
  },
}

local config = {
  flags = {
    allow_incremental_sync = true,
  },
}

config.cmd = {
  "java", -- or '/path/to/java17_or_newer/bin/java'
  "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  "-Dosgi.bundles.defaultStartLevel=4",
  "-Declipse.product=org.eclipse.jdt.ls.core.product",
  "-Dlog.protocol=true",
  "-Dlog.level=ALL",
  "-Xmx1g",
  "-javaagent:" .. lombok_path,
  "--add-modules=ALL-SYSTEM",
  "--add-opens",
  "java.base/java.util=ALL-UNNAMED",
  "--add-opens",
  "java.base/java.lang=ALL-UNNAMED",
  "-jar",
  path_to_jar,
  "-configuration",
  path_to_config,
  "-data",
  workspace_dir,
}

config.settings = {
  java = {
    references = {
      includeDecompiledSources = true,
    },
    format = {
      enabled = true,
      settings = {
        url = vim.fn.stdpath "config" .. "/lang_servers/intellij-java-google-style.xml",
        profile = "GoogleStyle",
      },
    },
    eclipse = {
      downloadSources = true,
    },
    maven = {
      downloadSources = true,
    },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org",
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
}

config.on_attach = on_attach
config.capabilities = capabilities
config.on_init = function(client, _)
  client.notify("workspace/didChangeConfiguration", { settings = config.settings })
end

local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

require("jdtls").start_or_attach(config)

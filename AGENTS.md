# Repository boundaries

## Current policy: installation and environment only

Nix and Home Manager are currently used for software installation and the
runtime environment. Home Manager is not permission to take ownership of the
user's application configuration.

- Keep application settings, desktop/QML source, dotfiles and runtime state out
  of Nix/Home Manager management. Their owners remain the user and their
  independent repositories.
- Do not add `home.file`, `xdg.configFile`, out-of-store configuration symlinks,
  activation scripts that copy/update a checkout, or generated application
  configuration merely to integrate an installed package.
- Do not add an `editable` mode or a machine-specific source/configuration path
  to a package installation. Use the application's standard discovery rules.
- Install complete runtime dependencies together. Do not require separate NixOS
  and Home Manager activations to assemble one application's runtime.
- Keep native upstream commands native. Do not replace the user's global
  `quickshell` (or another upstream command) with a project-specific wrapper.
  Any necessary compatibility wrapper must have a project-specific name.
- Session startup and personal desktop policy belong in dotfiles. Installing a
  package does not authorize starting it, enabling unrelated sessions, reloading
  the desktop, or restarting a locker/authentication agent.
- System-level integration that an explicitly requested component requires
  (for example PAM or greetd) must remain explicit and separate from application
  preferences; it must not acquire ownership of user configuration.
- Existing historical Home Manager/program modules are not a precedent for
  taking over more configuration. Do not migrate or remove unrelated existing
  settings as part of a software installation task.

Changing these ownership boundaries requires an explicit user instruction.
When scope is unclear, preserve ownership; do not silently reinterpret
"install" as "manage my configuration".

## Validation and publication

- Inspect repository instructions and local machine facts before changing an
  integration. Prefer installed tools or `nix develop` / `nix shell`.
- Build/evaluation does not authorize `switch` or starting/replacing services.
- Review diffs and staged files before commits; keep generated files, credentials,
  user state and temporary diagnostics out of Git.
- Pushes, releases and destructive history changes require explicit instruction.
  Preserve recoverable backups and use explicit force-with-lease checks for an
  authorized history rewrite.

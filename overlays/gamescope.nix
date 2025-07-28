self: super: {
  gamescope = super.gamescope.overrideAttrs (_old: {
    version = "git-2024-07";
    src = super.fetchFromGitHub {
      owner = "ValveSoftware";
      repo = "gamescope";
      rev = "bb18d55cf25e2bb38aef527209674f20220a76ae";
      sha256 = "sha256-X6Xgc6LHa2QiZs/sB7hegX/32BzCL9oInEhSxBOLvE0=";
      fetchSubmodules = true;
    };
  });
}

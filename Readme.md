# rules_cpan

Parse a `cpanfile.snapshot` file and provide the Perl dependencies as Bazel targets.

## Usage

See the tutorial in the [example](example) directory.

First, generate a `cpanfile.snapshot.lock.json` file from your `cpanfile.snapshot` using `bazel run @rules_cpan//lock`.

Then, add this to `MODULE.bazel`:
```Starlark
bazel_dep(name = "rules_cpan", version = "0.0.1")
cpan = use_extension("@rules_cpan//cpan:extensions.bzl", "cpan")
cpan.install(
    name = "cpan_deps",
    lock = "//:cpanfile.snapshot.lock.json",
)
use_repo(cpan, "cpan_deps")
```

Finally, use the `cpan_deps` target in your `BUILD` file:
```Starlark
load("@rules_perl//perl:perl.bzl", "perl_library")

perl_library(
    name = "my_perl_lib",
    srcs = ["lib/MyModule.pm"],
    deps = ["@cpan_deps"],
)
```

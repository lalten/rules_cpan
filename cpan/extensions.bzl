load("@rules_cpan//cpan:install.bzl", "install")

def _cpan_impl(module_ctx):
    for mod in module_ctx.modules:
        for attr in mod.tags.install:
            install(
                name = attr.name,
                lock = attr.lock,
                main_target_name = attr.name,
            )

cpan = module_extension(
    implementation = _cpan_impl,
    tag_classes = {
        "install": tag_class(
            attrs = {
                "name": attr.string(mandatory = True),
                "lock": attr.label(mandatory = True),
            },
        ),
    },
)

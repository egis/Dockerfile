## WireMock Container

A container that runs an instance of [wiremock](http://wiremock.org/) after downloading mappings from a remote location specified as an ENV variable.

While the "docker way" is too bake the mappings into the container, it does pose either a security risk if the mappings are sensitive or a complexity overhead for private images.

1. Create a zip file containing the  `mappings` and `__files` directories and publish it somwhere accessible via curl. e.g.. `http://site.com/mocks.zip`
2. `docker run -it --rm -p 9999 -e URL=http://site.com/mocks.zip egis/wiremock`


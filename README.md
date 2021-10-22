# simple-java-maven-app

This repository is for the
[Build a Java app with Maven](https://github.com/anujnarayan23/simple-java-maven-app-master)
tutorial in the [Jenkins User Documentation](https://jenkins.io/doc/).

The repository contains a simple Java application which outputs the string
"Hello world!" and is accompanied by a couple of unit tests to check that the
main application works as expected. The results of these tests are saved to a
JUnit XML report.

This repo has Jenkins file which contains multiple stages.
1. Clone repo
2. Compile with pushing artifacts to Artifactory
3. Junit test cases
4. Sonar
5. Docker build
6. Docker push - publish the image to artifact

Test

#!/bin/bash

repoUrls=""
features=""

cd /tmp/files/

while read line
do
  if [ -z "${line}" ]; then
    echo ""
  else
    echo -E "$line"
    if [ -z "${repoUrls}" ]; then
        repoUrls=$line
    else
        repoUrls="$line,$repoUrls"
    fi
  fi
done < "repositories.txt"

while read line
do
  if [ -z "${line}" ]; then
    echo ""
  else
    echo -E "$line"
    if [ -z "${features}" ]; then
        features=$line
    else
        features="$line,$features"
    fi
  fi
done < "features.txt"

echo "INSTALLING PLUGINS"
echo "USING REPOSITORIES $repoUrls"
echo "USING FEATURES $features"
#repoUrls=jar:https://repo.gradle.org/gradle/tooling-libs-releases-local/com/gradleware/tooling/p2-repository/0.11.3/p2-repository-0.11.3.zip\!/,jar:file:/tmp/aaa/springsource-tool-suite-3.6.4.RELEASE-e4.5-updatesite.zip\!/,http://download.eclipse.org/linuxtools/update-docker,http://download.eclipse.org/technology/epp/packages/mars/,http://download.eclipse.org/releases/mars,http://download.eclipse.org/releases/mars/201602261000,http://download.eclipse.org/eclipse/updates/4.5,http://dist.springsource.com/release/TOOLS/update/e4.5/,http://dist.springsource.org/snapshot/GRECLIPSE/e4.5/,http://download.eclipse.org/linuxtools/updates-docker-nightly/
#features=org.springsource.ide.eclipse.gradle.feature.feature.group,org.springsource.ide.eclipse.gradle.ui,org.springsource.ide.eclipse.gradle.feature.feature.jar,org.springsource.ide.eclipse.gradle.core,org.springsource.ide.eclipse.gradle.ui.taskview,org.springsource.ide.eclipse.gradle.toolingapi,com.gradleware.tooling.utils,com.gradleware.tooling.client,com.gradleware.tooling.model,org.gradle.toolingapi,org.grails.ide.eclipse.feature.group,org.grails.ide.eclipse.editor.groovy,org.grails.ide.eclipse.editor.gsp,org.grails.ide.eclipse.runonserver,org.grails.ide.eclipse.groovy.debug.core,org.grails.ide.eclipse.runtime13,org.grails.ide.eclipse.resources,org.grails.ide.eclipse.ui,org.grails.ide.eclipse.feature.jar,org.grails.ide.eclipse.search,org.grails.ide.eclipse.groovy.debug.ui,org.grails.ide.eclipse.core,org.grails.ide.eclipse.maven,org.grails.ide.eclipse.runtime22,org.grails.ide.eclipse.explorer,org.grails.ide.eclipse.runtime.shared,org.grails.ide.eclipse.refactoring,org.grails.ide.eclipse.feature.group,org.grails.ide.eclipse.editor.groovy,org.codehaus.groovy.eclipse.codeassist.completion,org.eclipse.jdt.groovy.core,org.codehaus.groovy.eclipse.astviews,org.codehaus.groovy.eclipse.codebrowsing,org.codehaus.groovy.eclipse.compilerResolver,org.codehaus.groovy.eclipse.core,org.codehaus.groovy.eclipse.dsl,org.codehaus.groovy.eclipse.quickfix,org.codehaus.groovy.eclipse.refactoring,org.codehaus.groovy,org.codehaus.groovy.eclipse.ui,org.codehaus.groovy.eclipse.ant,org.codehaus.groovy.eclipse,org.springframework.ide.eclipse.boot,org.springframework.ide.eclipse.boot.launch,org.springsource.ide.eclipse.commons.completions,org.springsource.ide.eclipse.commons.livexp,org.springframework.ide.eclipse.editor.support,org.springframework.ide.eclipse.boot.properties.editor,org.springsource.ide.eclipse.commons.quicksearch,org.springframework.aop,org.springframework.beans,org.springframework.ide.eclipse.boot.properties.editor.yaml,org.springframework.context,org.springframework.context.support,org.springframework.core,org.springframework.expression,org.springframework.ide.eclipse.doc,org.springframework.ide.eclipse,org.springframework.ide.eclipse.beans.core.autowire,org.springframework.ide.eclipse.beans.ui.graph,org.springframework.ide.eclipse.beans.ui.editor,org.springframework.ide.eclipse.beans.core,org.springframework.ide.eclipse.beans.mylyn,org.springframework.ide.eclipse.beans.ui,org.springframework.ide.eclipse.beans.ui.search,org.springframework.ide.eclipse.bestpractices,org.springframework.ide.eclipse.buildship,org.springframework.ide.eclipse,org.springsource.ide.eclipse.commons.cloudfoundry.client,org.springframework.ide.eclipse.config.graph,org.springframework.ide.eclipse.core,org.springframework.ide.eclipse.gradle,org.springframework.ide.eclipse.beans.ui.livegraph,org.springframework.ide.eclipse.maven,org.springframework.ide.eclipse.beans.core.metadata,org.springframework.ide.eclipse.mylyn,org.springframework.ide.eclipse.quickfix,org.springframework.ide.eclipse.beans.ui.refactoring,org.springframework.ide.eclipse.config.core,org.springframework.ide.eclipse.config.ui,org.springframework.ide.eclipse.metadata,org.springframework.ide.eclipse.wizard,org.springframework.ide.eclipse.ui,org.springframework.jdbc,org.springframework.jms,org.springframework.oxm,org.springframework.orm,org.springsource.ide.eclipse.commons.ui,org.springframework.transaction,org.springframework.web,org.springframework.web.servlet,org.springsource.ide.eclipse.commons.core,org.springsource.ide.eclipse.commons.content.core,org.springsource.ide.eclipse.commons.configurator,com.spotify.docker.client,org.eclipse.linuxtools.docker.core/1.1.0.201509161915,org.eclipse.linuxtools.docker.ui/1.1.0.201509161915,org.eclipse.linuxtools.docker.docs/1.1.0.201509161915,org.json

cd $1

./eclipse \
-nosplash \
-application org.eclipse.equinox.p2.director \
-repository $repoUrls \
-installIU $features \
-profileProperties org.eclipse.update.install.features=true \
-destination $1 \
-roaming \
-consoleLog \
-p2.os linux -p2.ws gtk -p2.arch x86_64 \
-profile epp.package.jee


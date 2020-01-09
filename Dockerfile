# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM node:10-buster AS build

WORKDIR /build

RUN apt-get -y update && \
	apt-get -y upgrade

COPY . /build/
RUN	npm install
RUN npm run build

FROM nginx:alpine AS runtime

LABEL org.opencontainers.image.title="CloudStack Primate" \
	org.opencontainers.image.description="A modern role-based progressive CloudStack UI" \
	org.opencontainers.image.authors="Apache CloudStack Contributors" \
	org.opencontainers.image.url="https://github.com/apache/cloudstack-primate" \
	org.opencontainers.image.documentation="https://github.com/apache/cloudstack-primate/README.md" \
	org.opencontainers.image.source="https://github.com/apache/cloudstack-primate" \
	org.opencontainers.image.vendor="The Apache Software Foundation" \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.ref.name="latest"

COPY --from=build /build/dist/. /usr/share/nginx/html/
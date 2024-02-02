# Utiliser l'image OpenJDK 11 comme image de base
FROM openjdk:11-jdk

# Copier le code source dans l'image Docker
COPY . /app

# Définir le répertoire de travail
WORKDIR /app

# Vérifier si OpenJDK est installé
RUN if command -v java &> /dev/null; then \
        echo "OpenJDK already installed. Nothing to do."; \
    else \
        apt-get update && \
        apt-get install -y openjdk-11-jdk && \
        echo "OpenJDK installed successfully."; \
    fi

# Vérifier si Maven est installé
RUN if command -v mvn &> /dev/null; then \
        echo "Maven already installed. Nothing to do."; \
    else \
        apt-get install -y maven && \
        echo "Maven installed successfully."; \
    fi

# Afficher les versions installées
RUN java -version
RUN mvn --version

# Vérifier si Docker est installé
RUN if command -v docker &> /dev/null; then \
        echo "Docker already installed. Nothing to do."; \
    else \
        apt-get install -y docker.io && \
        echo "Docker installed successfully." && \
        export PATH=$PATH:/usr/bin/docker; \
    fi

# Afficher la version de Docker
RUN docker --version

# Exécuter la commande de build Maven
RUN mvn clean install

# Commande par défaut pour démarrer votre application (ajustez selon votre besoin)
CMD ["java", "-jar", "target/votre-application.jar"]


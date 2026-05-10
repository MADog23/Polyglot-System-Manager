require("dotenv").config();

module.exports = {
    PORT: process.env.PORT || 3000,

    PYTHON_HOST: process.env.PYTHON_HOST || "localhost",
    PYTHON_PORT: process.env.PYTHON_PORT || 5000,

    JAVA_HOST: process.env.JAVA_HOST || "localhost",
    JAVA_PORT: process.env.JAVA_PORT || 8081
};

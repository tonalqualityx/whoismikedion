const config = {
    API_BASE: import.meta.env.PROD
        ? '/api'
        : 'http://localhost:3000/api',
};

export default config;
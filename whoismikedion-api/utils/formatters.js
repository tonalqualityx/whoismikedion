/**
 * Format date range
 * 
 * @param {Date} startDate - Start date
 * @param {Date|null} endDate - End date
 * @returns {string} Formatted date range
 */

function formatDateRange(startDate, endDate) {
    const start = new Date(startDate);
    const startYear = start.getFullYear();

    if(!endDate) {
        return `${startYear} - Present`;
    }

    const end = new Date(endDate);
    const endYear = end.getFullYear();
    
    return `${startYear} - ${endYear}`;
}

module.exports = {
    formatDateRange
};
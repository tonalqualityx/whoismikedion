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


/**
 * Format date range for display
 * @param {Date} startDate - Start date
 * @param {Date|null} endDate - End date (null = present)
 * @returns {string} Formatted date range
 */
function formatEmploymentRange(startDate, endDate) {
  const start = new Date(startDate);
  const startMonth = start.toLocaleDateString('en-US', { month: 'short' });
  const startYear = start.getFullYear();
  
  if (!endDate) {
    return `${startMonth} ${startYear} - Present`;
  }
  
  const end = new Date(endDate);
  const endMonth = end.toLocaleDateString('en-US', { month: 'short' });
  const endYear = end.getFullYear();
  
  return `${startMonth} ${startYear} - ${endMonth} ${endYear}`;
}

module.exports = {
    formatDateRange,
    formatEmploymentRange
};
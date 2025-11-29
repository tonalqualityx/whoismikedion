/**
 * HTML Sanitizer - Allowlist-based approach
 * Only permits safe HTML tags for chat message formatting
 */

const ALLOWED_TAGS = ['p', 'strong', 'em', 'ul', 'ol', 'li', 'code', 'pre', 'br', 'a'];
const ALLOWED_ATTRS = {
  a: ['href', 'target', 'rel'],
};

/**
 * Sanitize HTML string by removing disallowed tags and attributes
 * @param {string} html - Raw HTML string to sanitize
 * @returns {string} - Sanitized HTML string
 */
export function sanitizeHtml(html) {
  if (!html || typeof html !== 'string') {
    return '';
  }

  // Create a temporary DOM element
  const temp = document.createElement('div');
  temp.innerHTML = html;

  // Recursively clean nodes
  cleanNode(temp);

  return temp.innerHTML;
}

/**
 * Recursively clean a DOM node and its children
 * @param {Node} node - DOM node to clean
 */
function cleanNode(node) {
  // Process child nodes (create array copy since we may modify during iteration)
  const children = Array.from(node.childNodes);

  for (const child of children) {
    if (child.nodeType === Node.ELEMENT_NODE) {
      const tagName = child.tagName.toLowerCase();

      if (!ALLOWED_TAGS.includes(tagName)) {
        // Replace disallowed tag with its text content
        const text = document.createTextNode(child.textContent);
        node.replaceChild(text, child);
      } else {
        // Remove disallowed attributes
        const allowedAttrs = ALLOWED_ATTRS[tagName] || [];
        const attrs = Array.from(child.attributes);

        for (const attr of attrs) {
          if (!allowedAttrs.includes(attr.name)) {
            child.removeAttribute(attr.name);
          }
        }

        // For links, force safe attributes
        if (tagName === 'a') {
          child.setAttribute('target', '_blank');
          child.setAttribute('rel', 'noopener noreferrer');

          // Validate href - only allow http/https
          const href = child.getAttribute('href');
          if (href && !href.startsWith('http://') && !href.startsWith('https://')) {
            child.removeAttribute('href');
          }
        }

        // Recursively clean children
        cleanNode(child);
      }
    }
  }
}

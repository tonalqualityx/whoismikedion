#### Stories API Design

## GET /api/stories

### Description

Returns list of all stories with summary information.

### Query Parameters

- `skill` (optional) - Filter by skill_id (e.g., "product-strategy")

### Response Format

```json
{
  "stories": [
    {
      "id": 1,
      "story_id": "STORY-001",
      "title": "Story Title",
      "summary": "First 200 chars of context",
      "skills": ["skill1", "skill2"],
      "quantifiable_impact": "Measurable outcome"
    }
  ],
  "total": 12,
  "filtered": true/false
}
```

### SQL Strategy

- LEFT JOIN stories with story_skills
- LEFT JOIN story_skills with skills
- GROUP BY story to aggregate skills
- Use GROUP_CONCAT for skills array
- Apply WHERE filter if skill parameter present

## GET /api/stories/:story_id

### Description

Returns full story details including related skills and work history.

### URL Parameters

- `story_id` - Story identifier (e.g., "STORY-001")

### Response Format

```json
{
  "story_id": "STORY-001",
  "title": "Full Title",
  "context": "Full context",
  "challenge": "Full challenge",
  "solution": "Full solution", 
  "outcome": "Full outcome",
  "quantifiable_impact": "Outcome",
  "skills": [...],
  "work_history": [...]
}
```

### SQL Strategy

- Get story by story_id
- JOIN with skills via story_skills
- JOIN with work_history via work_story_links
- Return 404 if story not found

## Error Handling

- 404: Story not found
- 500: Database error
- 400: Invalid query parameters (future)

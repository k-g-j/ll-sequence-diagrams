# LayerLens Diagram Explanation Notes

## Evaluation AVS Diagrams

### 1. Task Creation and Assignment Flow (avs-task-flow)

- **Overview**: Task creation, assignment, and execution process
- **Task Creation**:
  1. Admin requests evaluation through task manager
  2. Task manager selects operator from internal assignment queue
  3. Task created and event emitted
- **Task Execution**:
  1. Operator listens for task events and checks assignment
  2. Fetches dataset files from S3 and API key for model
  3. GoEvaluator iterates through prompts, sending to LLM and scoring responses
  4. Generates cryptographic hash of results
- **Result Submission**:
  1. Detailed results saved to LayerLens API
  2. Operator generates BLS signature and submits to smart contract
  3. Contract verifies signature and updates task state
  4. Operator returned to assignment queue
- **Cryptographic Proof**: Hash and BLS signature ensure result integrity

### 2. Operator Registration Flow (avs-registration-flow)

- **Overview**: Process for registering a new operator with EigenLayer and AVS
- **Setup Process**:
  1. Operator runs init command to load existing keys and create config
  2. Docker setup created for containerized deployment
- **Registration Steps**:
  1. Operator node registers with EigenLayer using ECDSA and BLS keys
  2. Registration with EvalAvsServiceManager after EigenLayer verification
  3. Operator joins assignment queue (within EvalAvsTaskManager contract) to become eligible for tasks
- **Key Management**: Uses existing ECDSA keys for transaction signing, BLS keys for cryptographic verification
- **Configuration**: Creates necessary files for secure operation

### 3. Task Reassignment Flow (avs-reassignment-flow)

- **Overview**: Process for reassigning tasks when operators fail or time out
- **Reassignment Process**:
  1. Admin triggers reassignment of a task
  2. Task manager checks if task is expired
  3. Next operator selected from queue
  4. Task updated with new operator
- **Operator Handling**:
  1. Original operator notified and cancels processing
  2. New operator notified and begins evaluation
- **Fault Tolerance**: Ensures evaluations complete even when operators fail
- **Task Continuity**: New operator follows standard evaluation flow

### 4. Complete AVS System Architecture (avs-architecture)

- **Overview**: Architecture of the EigenLayer Actively Validated Service system
- **Key Components**:
  - Smart Contracts: Service manager, task manager, BLS registry, and stake registry
  - Operator: Service, CLI, task queue, BLS signing module, and config manager
  - Evaluator: Model client factory, response scorer, result processor
  - Infrastructure: Docker container, monitoring, health checking, slashing detection
  - External: EigenLayer core, dataset registry, LLM providers, LayerLens API
- **Component Relationships**: Shows how operator interacts with contracts, evaluators, and external services
- **Security Features**: BLS signing module, slashing detector for fraud prevention
- **Integration Points**: Connection to EigenLayer for staking and validation

## Atlas App Diagrams

### 1. User Authentication Flow (atlas-auth-flow)

- **Overview**: User authentication process using Next.js, NextAuth, and AWS Cognito
- **Login Flow**:
  1. User submits credentials through frontend
  2. NextAuth processes credentials and sends to AWS Cognito
  3. Cognito authenticates and returns JWT token
  4. Frontend stores token and redirects to dashboard
- **Protected Route Access**:
  1. User requests protected content
  2. Frontend sends request with auth token
  3. API validates token (with Cognito if needed)
  4. Database access only occurs after successful validation
- **Security Features**: JWT middleware, session-based authentication, token verification

### 2. Evaluation Creation and Processing Flow (atlas-evaluation-flow)

- **Overview**: End-to-end process of creating and executing model evaluations
- **Request Flow**:
  1. User selects model and dataset for evaluation
  2. API validates and stores request in MongoDB with PENDING status
  3. Request published to Kafka message queue
- **Worker Processing**:
  1. Worker consumes message and calls smart contract
  2. Contract assigns operator and creates task
  3. Worker updates database with task ID
- **AVS Processing**:
  1. Operator processes evaluation task
  2. Results submitted back to contract
- **Results Processing**:
  1. Worker listens for completion events
  2. Detailed results stored in S3
  3. Evaluation status updated to COMPLETED
  4. WebSocket notification sent to frontend
- **Real-time Updates**: WebSocket enables immediate UI updates when evaluations complete

### 3. Dataset Management Flow (atlas-dataset-flow)

- **Overview**: How datasets are uploaded, stored, and accessed in the system
- **Admin Upload Flow**:
  1. Admin uploads dataset files through the frontend
  2. Frontend validates format before sending to API
  3. API validates metadata and uploads files to S3
  4. Dataset metadata stored in MongoDB and registered in registry
- **User Browsing Flow**:
  1. User browses available datasets
  2. Frontend fetches dataset list from API
  3. MongoDB provides metadata for listing
- **Viewing Details**:
  1. User selects dataset for detailed view
  2. API fetches both metadata and sample data
  3. Frontend displays comprehensive dataset information
- **Storage Strategy**: Files in S3, metadata in MongoDB for efficient querying

### 4. Results Viewing and Comparison Flow (atlas-results-flow)

- **Overview**: How users view and compare evaluation results
- **Listing Evaluations**:
  1. User navigates to evaluations page
  2. API fetches user's evaluations from MongoDB
  3. Frontend displays evaluation list
- **Detailed Results**:
  1. User selects specific evaluation
  2. API fetches metadata from MongoDB and detailed results from S3
  3. Frontend processes and visualizes results with charts
- **Model Comparison**:
  1. User requests comparison between models
  2. API fetches aggregate metrics from MariaDB and specific evaluations from MongoDB
  3. Frontend generates comparison visualizations
- **Data Sources**: Combines information from both MongoDB (metadata) and S3 (result data)

### 5. Complete Atlas System Architecture (atlas-architecture)

- **Overview**: Complete system architecture showing all components of the Atlas platform
- **Key Components**:
  - Frontend: React-based web UI with Next.js and authentication via NextAuth
  - API: Go-based backend with API gateway, rate limiting, and WebSocket support
  - Core: Service managers for evaluations, models, datasets, users, and results
  - Integration: Workers that handle evaluation tasks and interact with AVS contracts
  - Data: MongoDB for metadata, MariaDB for metrics, S3 for storage, Kafka for messaging
  - External: AWS Cognito for auth, LayerLens AVS service, third-party LLM providers
- **Data Flow**: User interactions start at frontend, pass through API layer to core services, which interact with databases and external services
- **Color Coding**: Different component types use distinct colors for easy identification
- **Integration Points**: Shows how Atlas communicates with the AVS system

## Common Styling Elements

- **Color Coding**: Consistent colors identify component types across all diagrams
- **Legend**: Each diagram includes a legend explaining the color scheme
- **Component Types**: Frontend, API, Auth, Database, External, Contract, Queue, Operator, Evaluator, Storage
- **Visual Consistency**: Standardized styling for boxes, arrows, and notes

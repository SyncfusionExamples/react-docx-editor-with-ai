# AI-Powered React DOCX Editor (Document Editor) sample

A sample project showcasing the [React DOCX Editor](https://www.syncfusion.com/docx-editor-sdk/react-docx-editor?utm_source=github&utm_medium=listing&utm_campaign=github-github-documenteditor-examples) (Document Editor) with AI assistance for generating, refining, and summarizing content.

## Getting Started

To get started, clone the `ai-powered-react-docx-editor-sample` repository.

```
git clone https://github.com/SyncfusionExamples/ai-powered-react-docx-editor-sample.git
```

## Installation

All required packages are pre-configured in the `package.json` file. Install the dependencies by running:

```
npm install
```

## License Registration

Before using the Syncfusion DOCX Editor, register your license key in the `src/index.tsx` file:

```
import { registerLicense } from '@syncfusion/ej2-base';

// Registering Syncfusion license key
registerLicense('Replace your generated license key here');

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
```

For more details on license registration, refer to the [official documentation](https://ej2.syncfusion.com/react/documentation/licensing/license-key-registration#register-syncfusion-license-key-in-the-project).

## Configuring AI Services

To set up the AI services, navigate to `src/ai-models.ts` and replace the placeholders with your actual credentials:

```
const azure = createAzure({
    resourceName: 'YOUR_RESOURCE_NAME',
    apiKey: 'YOUR_API_KEY',
});
const aiModel = azure('YOUR_MODEL_NAME');

// for gemini model
const google = createGoogleGenerativeAI({
    baseURL: "https://generativelanguage.googleapis.com/v1beta",
    apiKey: "API_KEY"
});
const aiModel = google('YOUR_MODEL_NAME');
```

Your Azure endpoint should resemble: `https://{resource_name}.openai.azure.com/`

For more information on Azure OpenAI configuration, consult the [Vercel AI SDK documentation](https://sdk.vercel.ai/providers/ai-sdk-providers/azure).

## Development Server

To run the application, use the following npm script:

```
npm start
```

This command will start the DOCX Editor and open it in your default web browser.

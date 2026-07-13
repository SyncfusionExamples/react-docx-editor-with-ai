const API_BASE = "http://localhost:5243/api/document-ai";

export async function getAzureChatAIRequest(options: any) {

    try {

        const response = await fetch(
            `${API_BASE}/process`,
            {
                method: "POST",

                headers: {
                    "Content-Type": "application/json"
                },

                body: JSON.stringify(options)
            });

        if (!response.ok) {

            throw new Error(
                `API Error : ${response.status}`);
        }

        const result = await response.json();

        return result.text;

    }
    catch (err) {

        console.error(err);

        return null;
    }
}